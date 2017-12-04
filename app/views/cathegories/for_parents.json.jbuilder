json.array! @cathegories do |cathegory|
  json.(cathegory, :id, :name, :icon, :show, :parent_id)
  json.properties do
    json.array cathegory.properties, :name, :control_type, :values, :prefix, :postfix
  end
end
