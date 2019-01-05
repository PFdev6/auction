class BroadcastUpdateBargain
  include Interactor
  

  def call
    current_bargain = context.bargain
    ActionCable.server.broadcast "update_bargain:#{current_bargain.id}", I18n.t('bargain_was_updated')
  end
end