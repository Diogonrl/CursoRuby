require 'test_helper'

class PostTest < ActiveSupport::TestCase
    
    def setup
        @user = User.create!(name: "diogo", email: "diogo@example.com")
        @post = @user.posts.build(name: "Oaeqeq", description: "helloworldsadadasdasdaswmdmlçmdlçqwmdçld")
    end

    test "post sem usuario" do
        @post.user_id = nil
        assert_not @post.valid?
    end

    test "post é valido" do
        assert @post.valid? 
    end
    test "name tem que existir" do
        @post.name = " "
        assert_not @post.valid? 
    end
    test "description tem que existir" do
        @post.description = " "
        assert_not @post.valid? 
    end
    test "description tem que ser menor que 500" do
        @post.description = "a" * 3
        assert_not @post.valid? 
    end
    test "description tem maior que 5" do
        @post.description = "a" * 501
        assert_not @post.valid? 
    end
end

