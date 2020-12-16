require 'test_helper'

class PostsDeleteTest < ActionDispatch::IntegrationTest
  def setup 
    @user = User.create!(name: "diogo", email: "diogo@example.com")
    @post = Post.create(name: "Post", description: "escreva aqui seu post", user: @user)
  end 

  test "successfully delete a post" do
    get post_path(@post)
    assert_template 'posts/show'
    assert_select 'a[href=?]', post_path(@post), text: "Delete this post"
    assert_difference 'post.count', -1 do
      delete post_path(@post)
    end
    assert_redirected_to posts_path
    assert_not flash.empty?
  end

end

 