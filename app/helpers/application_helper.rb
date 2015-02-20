module ApplicationHelper


  # Code from https://gist.github.com/suryart/7418454
  BOOTSTRAP_FLASH_MSG = {
    success: 'alert alert-success',
    error: 'alert alert-error',
    alert: 'alert alert-warning',
    notice: 'alert alert-info'
  }

  def bootstrap_class_for(flash_type)
    BOOTSTRAP_FLASH_MSG[flash_type.to_sym]
  end



end
