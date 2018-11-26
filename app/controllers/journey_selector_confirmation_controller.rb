class JourneyConfirmationSelectorController < ApplicationController
  def select_journey
    journey_type = params[:journey_type]
    if journey_type == "NON_MATCHING_JOURNEY_SUCCESS"
      report_to_analytics('Outcome - Matching Not Used By Service')
      redirect_to redirect_to_service_signing_in_path
    else
      confirmation_path(journey_type)
    end
  end
end