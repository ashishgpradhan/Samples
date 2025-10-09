resource "aws_guardduty_detector" "GuardDuty" {
  provider = aws.ProductionRegion
  enable   = true
}