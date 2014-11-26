class RegistrationsController < Devise::RegistrationsController
    after_filter :create_roster_and_team

    protected

    def create_roster_and_team
      CreateDemoTeamService.execute(resource) if resource.persisted?
    end
end