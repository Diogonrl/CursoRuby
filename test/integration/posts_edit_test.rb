require 'test_helper'

class PostsEditTest < ActionDispatch::IntegrationTest

  def setup 
    @user = User.create!(name: "diogo", email: "diogo@example.com")
    @post = Post.create(name: "Post", description: "escreva aqui seu post", user: @user)
  end

  test "Rejeita update invalidos" do
    get edit_post_path(@post)
    assert_template 'posts/edit'
    patch post_path(@post), params: {post: {name: " ", description: "descrição"}}
    assert_template 'posts/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'  
  end
  test "Sucesso no update" do
    get edit_post_path(@post)
    assert_template 'posts/edit'
    updated_name = "nome atualizado"
    updated_description = "descrição atualizada"
    patch post_path(@post), params: {post: {name:updated_name, description: updated_description}}
    assert_redirected_to @post
    #follow_redirect!
    assert_not flash.empty?
    @post.reload
    assert_match updated_name @post.name
    assert_match updated_description @post.description
  end
end
