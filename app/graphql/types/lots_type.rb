module Types
  class LotsType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :description, String, null: true
    field :start_price, Float, null: true
    field :lot_end_date, GraphQL::Types::ISO8601DateTime, null: true
    field :autopurchase_price, GraphQL::Types::ISO8601DateTime, null: true
  end
end
