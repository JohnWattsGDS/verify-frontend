class FeedbackSourceMapper
  def initialize(product_page_url)
    @page_to_source_mappings = {
      'ABOUT_CERTIFIED_COMPANIES_PAGE' => 'about_certified_companies',
      'ABOUT_CHOOSING_A_COMPANY_PAGE' => 'about_choosing_a_company',
      'ABOUT_IDENTITY_ACCOUNTS_PAGE' => 'about_identity_accounts',
      'ABOUT_PAGE' => 'about',
      'CHOOSE_A_CERTIFIED_COMPANY_PAGE' => 'choose_a_certified_company',
      'CERTIFIED_COMPANY_UNAVAILABLE_PAGE' => 'choose_a_certified_company',
      'CHOOSE_A_COUNTRY_PAGE' => 'choose_a_country',
      'CONFIRM_YOUR_IDENTITY' => 'confirm_your_identity',
      'CONFIRMATION_PAGE' => 'confirmation',
      'COOKIE_NOT_FOUND_PAGE' => nil,
      'ERROR_PAGE' => 'start',
      'FAILED_UPLIFT_PAGE' => 'failed_uplift',
      'IDP_WILL_NOT_WORK_FOR_YOU' => 'idp_wont_work_for_you_one_doc',
      'EXPIRED_ERROR_PAGE' => nil,
      'FAILED_REGISTRATION_PAGE' => 'failed_registration',
      'FAILED_SIGN_IN_PAGE' => 'failed_sign_in',
      'FAILED_COUNTRY_SIGN_IN_PAGE' => 'failed_country_sign_in',
      'EIDAS_SCHEME_UNAVAILABLE' => 'redirect_to_country',
      'CYCLE_3_PAGE' => 'further_information',
      'OTHER_WAYS_PAGE' => 'other_ways_to_access_service',
      'REDIRECT_TO_IDP_WARNING_PAGE' => 'redirect_to_idp_warning',
      'MATCHING_ERROR_PAGE' => 'response_processing',
      'ACCOUNT_CREATION_FAILED_PAGE' => 'response_processing',
      'SELECT_DOCUMENTS_PAGE' => 'select_documents',
      'SELECT_DOCUMENTS_PAGE_PHOTO_DOCUMENTS' => 'select_documents',
      'UNLIKELY_TO_VERIFY_PAGE' => 'unlikely_to_verify',
      'SELECT_PHONE_PAGE' => 'select_phone',
      'VERIFY_WILL_NOT_WORK_FOR_YOU' => 'verify_will_not_work_for_you',
      'SIGN_IN_PAGE' => 'sign_in',
      'START_PAGE' => 'start',
      'COOKIES_INFO_PAGE' => 'cookies',
      'FORGOT_COMPANY_PAGE' => 'forgot_company',
      'PRIVACY_NOTICE_PAGE' => 'privacy_notice',
      'VERIFY_SERVICES_PAGE' => 'verify_services',
      'WHY_COMPANIES_PAGE' => 'why_companies',
      'WILL_IT_WORK_FOR_ME_PAGE' => 'will_it_work_for_me',
      'MAY_NOT_WORK_IF_YOU_LIVE_OVERSEAS_PAGE' => 'may_not_work_if_you_live_overseas',
      'WHY_THIS_MIGHT_NOT_WORK_FOR_ME_PAGE' => 'why_might_this_not_work_for_me',
      'WILL_NOT_WORK_WITHOUT_UK_ADDRESS_PAGE' => 'will_not_work_without_uk_address',
      'OTHER_IDENTITY_DOCUMENTS_PAGE' => 'other_identity_documents',
      'PRODUCT_PAGE' => product_page_url,
      'NO_IDPS_AVAILABLE' => 'no_idps_available',
      'CANCELLED_REGISTRATION' => 'cancelled_registration',
      'PROOF_OF_ADDRESS' => 'select_proof_of_address',
      'CONFIRMING_IT_IS_YOU_PAGE' => 'confirming_it_is_you',
      'PROVE_IDENTITY_PAGE' => 'prove_identity',
      'CONTINUE_TO_YOUR_IDP_PAGE' => 'continue_to_your_idp',
      'RESUME_PAGE' => 'resume_registration',
      'TIMEOUT_PAGE' => 'further_information_timeout'
  }.freeze
  end

  def is_feedback_source_valid(feedback_source)
    return true if feedback_source.starts_with?('CHOOSE_A_CERTIFIED_COMPANY_ABOUT_')

    @page_to_source_mappings.has_key?(feedback_source)
  end

  def page_from_source(feedback_source, locale)
    route_name = route_name_from(feedback_source)
    if route_name.nil?
      nil
    elsif route_name.match?(/https?:.*/)
      route_name
    else
      '/' + I18n.translate('routes.' + route_name, locale: locale)
    end
  end

private

  def route_name_from(feedback_source)
    if feedback_source && feedback_source.starts_with?('CHOOSE_A_CERTIFIED_COMPANY_ABOUT_')
      'choose_a_certified_company'
    else
      @page_to_source_mappings.fetch(feedback_source, 'start')
    end
  end
end
