resource "aws_kms_key" "kms_key" {
  description = "RDS Encryption"
  deletion_window_in_days = 30
}

resource "aws_db_subnet_group" "main_subnet_group" {
  subnet_ids = var.main_subnet_ids
}

resource "aws_iam_role" "rds_monitoring_role" {
  name = "rds-monitoring-role"
  assume_role_policy = jsonencode({
  Version = "2012-10-17",
  Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
        Service = "monitoring.rds.amazonaws.com"
      }
    }
  ]
})
}


resource "aws_iam_policy_attachment" "rds_monitoring_attachment" {
  name = "rds-monitoring-attachment"
  roles = [aws_iam_role.rds_monitoring_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"

}

resource "aws_db_instance" "db" {
  allocated_storage = var.allocated_storage
  storage_type = "gp2"
  engine = "mysql"
  engine_version = "5.7"
  instance_class = var.instance_class
  identifier = var.db_name
  username = var.username
  password = var.password

  vpc_security_group_ids = var.sg_list
  db_subnet_group_name = aws_db_subnet_group.main_subnet_group.id

  backup_retention_period = 7
  backup_window = "03:00-04:00"
  maintenance_window = "mon:04:00-mon:04:30"
  skip_final_snapshot = true
  monitoring_interval = 60
  monitoring_role_arn = aws_iam_role.rds_monitoring_role.arn
  storage_encrypted = true
  kms_key_id = aws_kms_key.kms_key.arn
  parameter_group_name = aws_db_parameter_group.db_pmg.name
  multi_az = true

}

resource "aws_db_instance" "db_replica" {
  instance_class  = var.instance_class
  identifier      = "${var.db_name}-replica"  # Unique identifier for the replica

  vpc_security_group_ids = var.sg_list

  backup_retention_period = 7
  backup_window           = "03:00-04:00"
  maintenance_window      = "mon:04:00-mon:04:30"
  final_snapshot_identifier = null
  skip_final_snapshot = true
  monitoring_interval      = 60
  storage_encrypted        = true
  kms_key_id               = aws_kms_key.kms_key.arn
  monitoring_role_arn = aws_iam_role.rds_monitoring_role.arn
  parameter_group_name     = aws_db_parameter_group.db_pmg.name
  replicate_source_db      = aws_db_instance.db.identifier
  multi_az                  = false  
}

resource "aws_db_parameter_group" "db_pmg" {
  name = "${var.db_name}-pmg"
  family      = "mysql5.7"  # Use the appropriate family for your MySQL version
  description = "My custom parameter group for MySQL"

  parameter {
    name = "connect_timeout"
    value = "15"
  }
}

