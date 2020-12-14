require 'test_helper'

class UserTest < ActiveSupport::TestCase

    def setup
        @user = User.new(name: "Oaeqeq", email: "helloworld@example.com")
    end

    test "user tem que ser valido" do
        assert @user.valid? 
    end

    test "name tem que existir" do
        @user.name = " "
        assert_not @user.valid? 
    end

    test "email tem que existir" do
        @user.email = " "
        assert_not @user.valid? 
    end
    
    test "email tem que ser menor que 30" do
        @user.name = "a" * 31
        assert_not @user.valid? 
    end

    test "email tem que ser menor que 255" do
        @user.email = "a" * 245 + "@example.com"
        assert_not @user.valid? 
    end
    
    test "email aceita apenas de forma correta" do
        valid_emails = %w[user@example.com Diogo@gmail.com M.first@yahoo.ca john+smith@co.uk.org]
        valid_emails.each do |valids|
            @user.email = valids 
            assert @user.valid?, "#{valids.inspect} should be valid"
        end   
    end
    
    test "rejeita emails falsos" do
        invalid_emails = %w[user@example Diogo@gmail,com M.first@ygmail. john@bar+foo.com]
        invalid_emails.each do |invalids|
            @user.email = invalids 
            assert_not @user.valid?, "#{invalids.inspect} should be invalid"
         end
    end
    test "email tem que ser unico" do
        duplicate_user = @user.dup
        duplicate_user.email = @user.email.upcase
        @user.save
        assert_not duplicate_user.valid?
    end

    test "email" do
        mixed_email = "JohN@Example.com"
        @user.email = mixed_email
        @user.save
        assert_equal mixed_email.downcase, @user.reload.email
    end
end
