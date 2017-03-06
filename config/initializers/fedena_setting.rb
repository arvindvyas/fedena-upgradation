FEDENA_DEFAULTS = {
  :company_name => 'Campus Management System',
  :company_url  => 'http://www.arvindvyas.com'
}

USER_SETTINGS = {}

if File.exists?("#{Rails.root}/config/company_details.yml")
  company_settings = YAML.load_file(File.join(RAILS_ROOT,"config","company_details.yml"))
  USER_SETTINGS = {:company_name => company_settings['company_details']['company_name'],
                   :company_url  => company_settings['company_details']['company_url']
  }
end

FEDENA_SETTINGS = FEDENA_DEFAULTS.merge!(USER_SETTINGS)

 