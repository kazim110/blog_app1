require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.feature 'User Show Page', type: :feature do
  before(:each) do
    @user = User.create(name: 'User 1', photo: 'url1', bio: 'Bio 1', posts_counter: 1)
    @post = @user.posts.create(title: 'Post Title', text: 'Post Body')
    @post.save(validate: false)
    @comment1 = @post.comments.create(user: @user, text: 'Comment 1')
    @comment2 = @post.comments.create(user: @user, text: 'Comment 2')
    3.times do
      @post.likes.create(user: @user)
    end
  end

  context 'when viewing user details' do
    # Add test cases related to user details here
    scenario 'I can see post details(title, author, numbers of comment&likes, body, commenter usernames)' do
      visit user_post_path(user_id: @user.id, id: @post.id)
      expect(page).to have_content(@user.name)
      expect(page).to have_content(@post.text)
      expect(page).to have_content('Comments: 2, Likes: 3')
      @post.comments.each do |comment|
        expect(page).to have_content(comment.user.name)
        expect(page).to have_content(comment.text)
      end
    end
  end

  context 'when interacting with user actions' do
    # Add test cases related to user actions here
    scenario 'Display user profile information' do
      visit user_path(@user)
      expect(page).to have_content(@user.name)
      expect(page).to have_content(@user.bio)
    end
    scenario 'Display recent posts and related details' do
      @post2 = @user.posts.create(title: 'Post Title 2', text: 'Post Body 2')
      @post3 = @user.posts.create(title: 'Post Title 3', text: 'Post Body 3')
      @post2.save(validate: false)
      @post3.save(validate: false)
      visit user_path(@user)
      expect(page).to have_content("Post##{@post2.id}")
      expect(page).to have_content('Post Body 2')
    end
  end
end
# rubocop:enable Metrics/BlockLength
