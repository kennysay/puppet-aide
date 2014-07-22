# the aide class manages some the configuration of aide
class aide (
    $package      = $aide::params::package,
    $version      = $aide::params::version,
    $conf_path    = $aide::params::conf_path,
    $db_path      = $aide::params::db_path,
    $db_temp_path = $aide::params::db_temp_path,
    $hour         = $aide::params::hour
  ) inherits aide::params {

  anchor { 'aide::begin': } ->
  class  { '::aide::install': } ->
  class  { '::aide::config': } ~>
  class  { '::aide::firstrun': } ->
  class  { '::aide::cron': } ->
  anchor { 'aide::end': }

  $aide_rules = hiera_hash( 'aide::rules_hash', $aide::params::aide_rules_defaults )
  create_resources('aide::rule', $aide_rules)

  $aide_watch = hiera_hash( 'aide::watch_hash', $aide::params::aide_watch_defaults )
  create_resources('aide::watch', $aide_watch)
}
