resource "aws_sqs_queue" "OrderQueue" {
  name                      = "orderprocessing.fifo"
  visibility_timeout_seconds = 30
  message_retention_seconds  = 86400
  fifo_queue = true
}