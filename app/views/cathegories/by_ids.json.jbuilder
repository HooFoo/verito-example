json.data do
  json.categories do
    json.array! @cathegories do |cathegory|
      json.(cathegory, :id, :name, :icon, :show, :parent_id)
      json.properties do
        json.array cathegory.properties, :id, :name, :control_type, :values, :prefix, :postfix
      end
    end
  end
  json.parents do
    json.array! @parents
  end
end