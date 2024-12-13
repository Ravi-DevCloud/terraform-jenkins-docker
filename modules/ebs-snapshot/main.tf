# resource "aws_dlm_lifecycle_policy" "daily_snapshot_policy" {
  
#   policy_details {
#     resource_types = ["VOLUME"]
#   }
#   name = "daily-snapshot-policy"
#   description = "Create daily snapshots of EBS volumes"

#   execution_role_arn = aws_iam_role.dlm_role.arn

#     rules {
#     rule_name = "CreateDailySnapshots"

#     interval = "1"
#     interval_unit = "DAYS"
#     }
#     }
resource "aws_backup_vault" "backup_vault" {
  name = "default"
}

resource "aws_backup_plan" "backup_plan" {
  name = "daily-ebs-backup"
  
  rule {
    rule_name = "daily-backup"
    target_vault_name = aws_backup_vault.backup_vault.name
    schedule = "cron(0 12 * * ? *)"
    lifecycle {
      delete_after = 14
    }
    
  }
}

resource "aws_backup_selection" "example" {
  iam_role_arn = aws_iam_role.backup_role.arn
  name         = "tf_example_backup_selection"
  plan_id      = aws_backup_plan.backup_plan.id

  resources = [ var.target_ebs_volume_arn
  ]
}

resource "aws_iam_role" "backup_role" {
  assume_role_policy = jsonencode(
    {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "backup.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]

  })
}

resource "aws_iam_role_policy_attachment" "backup_role_policy" {
  role = aws_iam_role.backup_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}