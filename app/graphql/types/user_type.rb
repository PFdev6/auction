module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :email, String, null: true
    field :lots, [Types::LotsType], null: true
    field :lots_count, Integer, null: true

    def lots_count
      lots.counts
    end
  end
end
