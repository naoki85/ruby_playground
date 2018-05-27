json.partial! 'v1/shared/common'
json.set! :summary do
  json.date @date_array
  json.pages @page_by_date_array
end
