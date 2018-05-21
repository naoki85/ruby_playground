json.partial! 'v1/shared/common'
json.set! :publishers do
  json.array! @publishers do |publisher|
    json.id publisher.id
    json.name publisher.name
  end
end
