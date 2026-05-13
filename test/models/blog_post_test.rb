require "test_helper"

class BlogPostTest < ActiveSupport::TestCase
  test "draft state methods" do
    post = blog_posts(:draft)

    assert post.draft?
    refute post.published?
    refute post.scheduled?
  end

  test "blog post requires a title" do
    post = BlogPost.new(body: "Test")

    assert_not post.save
  end

  test "blog post requires content" do
    post = BlogPost.new(title: "Test")

    assert_not post.save
  end

  test "blog posts unexpected input" do
    post = BlogPost.new(
      title: "!@#$%^&*()_+🔥 漢字 🚀",
      body: "Weird chars: ñ ü æ ø å € © ™ <script>alert('x')</script>"
    )

    assert post.save
    assert_equal "!@#$%^&*()_+🔥 漢字 🚀", post.title
    assert_includes post.body, "ñ"
    assert_includes post.title, "🚀"
  end

  test "sql injection stuff" do
    sqlinjection = "'; DROP TABLE blog_posts; --"

    results = BlogPost.where(
      "title LIKE ?",
      "%#{sqlinjection}%"
    )

    puts results.to_sql
    assert_not_nil results
    assert BlogPost.table_exists?,
          "blog posts still exists"
  end
end