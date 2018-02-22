class BaseService
  class ServiceStandardError < StandardError
    def message
      I18n.t('base_service.error.standard')
    end
  end

  class SaveError < ServiceStandardError
    def message
      I18n.t('base_service.error.save')
    end
  end
end