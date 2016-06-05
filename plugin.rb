# name: show-private-categories
# about: Show private categories in category list and allow requesting access
# version: 0.0.1
# authors: Jose Rilla

enabled_site_setting :show_private_categories

after_initialize do

  Category.class_eval do
    attr_accessor :is_private
  end

  CategoryDetailedSerializer.class_eval do
    attributes :is_private

    def is_private
      object.is_private
    end
  end

  module CategoryListExtensions
    def initialize(guardian=nil, options = {})
      if SiteSetting.show_private_categories
        $old_scope = Category.method(:secured)
        Category.define_singleton_method(:secured) { |guardian| all }
      end

      super(guardian, options)

      if SiteSetting.show_private_categories
        Category.define_singleton_method($old_scope.name, &$old_scope)
      end
    end

    def find_categories
      super
      @categories.each do |category|
        category.is_private = !@guardian.can_see_category?(category)
      end
    end
  end

  CategoryList.class_eval do
    prepend CategoryListExtensions
  end
end
