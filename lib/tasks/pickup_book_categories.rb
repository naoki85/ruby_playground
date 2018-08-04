class Tasks::PickupBookCategories
  def self.execute
    pickup_book_category_ids = Book.pickup_categories
    BookCategory.update_pickups(pickup_book_category_ids)
  end
end
