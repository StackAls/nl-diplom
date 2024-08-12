variable "s3_name" {
  type    = string
  default = "stackals-tfm-bkt"
}

variable "s3_size" {
  type    = number
  default = 1073741824
}

variable "s3_class" {
  type    = string
  default = "STANDARD"
}

