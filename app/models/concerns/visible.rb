module Visible
    extend ActiveSupport::Concern
    VALID_STATES = ['public', 'archived']

    included do
        validates :status, inclusion: {in: VALID_STATES}
    end

    def archived?
        status == 'archived'
    end
end