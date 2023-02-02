resource "time_sleep" "wait_30_seconds" {
  depends_on = [
       aws_security_group.websg
]

  create_duration = "30s"
}
