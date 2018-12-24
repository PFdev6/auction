class AddJobIdToCurrentBargains < ActiveRecord::Migration[5.2]
  def change
    add_reference :current_bargains, :delayed_job, index: true
  end
end
