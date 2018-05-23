json.partial! 'v1/shared/common'
json.set! :publisher do
  json.id @publisher.id
  json.name @publisher.name
end
