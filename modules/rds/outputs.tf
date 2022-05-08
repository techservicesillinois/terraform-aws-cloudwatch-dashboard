output "widget_definition" {
  value = concat(local.widget_definition_io, local.widget_definition_storage)
}
