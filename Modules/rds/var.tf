variable "allocated_storage" {
  description = "The amount of storage (in gigabytes) to be allocated for the DB instance."
  type        = number
}

variable "instance_class" {
  description = "The instance class of the DB instance."
  type        = string
}

variable "db_name" {
  description = "The name of the database."
  type        = string
}

variable "username" {
  description = "The master username for the DB instance."
  type        = string
}

variable "password" {
  description = "The master password for the DB instance."
  type        = string
  sensitive   = true
}

variable "sg_list" {
  description = "A list of security group IDs to associate with the DB instance."
  type        = list(string)
}

variable "main_subnet_ids" {
  description = "List of the DB subnet group for the main DB instance."
  type        = list(string)
}