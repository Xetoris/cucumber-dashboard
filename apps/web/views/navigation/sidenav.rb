# apps/web/views/home/index.rb
module Web::Views::Home
  class Index
    include Web::View

    def nav_items
      [
          {
              :link => routes.home_path,
              :text => 'Home',
              :icon => 'star'
          },
          {
              :link => '/test',
              :text => 'Test Page',
              :icon => 'rocket'
          }
      ]
    end
  end
end