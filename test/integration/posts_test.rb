require 'test_helper'

class PostsTest < ActionDispatch::IntegrationTest

  def setup 
    @user = User.create!(name: "diogo", email: "diogo@example.com")
    @post = Post.create(name: "Post", description: "escreva aqui seu post", user: @user)
    @post2 = @user.posts.build(name: "Post2", description: "escreva aqui seu post2")
    @post2.save
  end

  test "should get recipes index" do
    get posts_path
    assert_response :success
  end

  test "lista de receitas " do
    get posts_path
    assert_template 'posts/index'
    assert_select "a[href=?]". post_path(@post), text: @post.name
    assert_select "a[href=?]". post_path(@post), text: @post2.name
  end

  test " mostrar posts " do
    get post_path(@post)
    assert_template 'post/show'
    assert_match @post.name, response.body
    assert_match @post.description, response.body
    assert_match @user.name, response.body
  end 

  test "criar novo post" do
    get new_post_path
    assert_template 'post/new'
    name_of_post = "postpsot"
    description_of_post = "description description description description description description"
    assert_difference "Post.count", 1 do
      post posts_path, params: {post: { name: name_of_post, description: description_of_post} }
    end
    follow_redirect!
    assert_match name_of_post.capitalize, response.body
    assert_match description_of_post, response.body
  end

  test "recusar post invalido" do
    get new_post_path
    assert_template 'posts/new'
    assert_no_difference 'Post.count'do
      post posts_path, params: {post: { name: " ", description: " "} }
    end
    assert_template 'posts/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'       
  end

end
