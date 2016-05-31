# name: show-private-categories
# about: See private categories in category list
# version: 0.0.1
# authors: Jose Rilla

enabled_site_setting :show_private_categories

after_initialize do
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
  end

  CategoryList.class_eval do
    prepend CategoryListExtensions
  end
end
