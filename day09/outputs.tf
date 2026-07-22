output "string_functions" {
  value = {
    upper     = local.environment_upper
    lower     = local.project_lower
    title     = local.title_name
    replace   = local.replaced_name
    format    = local.formatted_name
    join       = local.joined_name
    split      = local.split_name
    trim       = local.trimmed_name
  }
}

output "collection_functions" {
  value = {
    total_subnets = local.total_public_subnets
    all_subnets   = local.all_subnets
    unique_servers = local.unique_servers
    flat_list     = local.flat_list
    contains_web  = local.contains_web
  }
}

output "map_functions" {
  value = {
    lookup = local.instance_type
    keys   = local.server_names
    values = local.server_types
    tags   = local.merged_tags
  }
}

output "file_function" {
  value = local.userdata_file
}

output "template_function" {
  value = local.userdata_template
}

output "base64_function" {
  value = local.userdata_base64
  sensitive = true
}

output "json_function" {
  value = local.sample_policy
}