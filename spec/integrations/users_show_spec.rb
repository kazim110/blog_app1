require 'rails_helper'

RSpec.feature 'User Show Page', type: :feature do
  before(:each) do
    # Create a user for testing
    @user = User.create(name: 'User 1', photo: 'url1', bio: 'Bio 1', posts_counter: 1)
    @post = @user.posts.create(title: 'Post Title', text: 'Post Body')
    @post.save(validate: false)
    @comment1 = @post.comments.create(user: @user, text: 'Comment 1')
    @comment2 = @post.comments.create(user: @user, text: 'Comment 2')
    3.times do
      @post.likes.create(user: @user)
    end
  end

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


  scenario 'Display user profile information' do
    visit user_path(@user)

    # Check if user profile information is displayed
    # expect(page).to have_content(@user.name)
    # Add more expectations for other user attributes, e.g., photo, bio, etc.
  end

  scenario 'Display recent posts and related details' do
    # Create posts associated with the user
    # @post2 = @user.posts.create(title: 'Post Title 2', text: 'Post Body 2')
    # @post3 = @user.posts.create(title: 'Post Title 3', text: 'Post Body 3')

    # visit user_path(@user)
    # save_and_open_page

    # # Check if recent posts and related details are displayed
    # expect(page).to have_content('Post Title 1')
    # Add more expectations for other post details, e.g., body, comments, likes, etc.
  end
  
    # scenario 'Display recent posts and related details' do
    #   visit user_path(@user)
  
    #   # Check if recent posts and related details are displayed
    #   expect(page).to have_content('Recent Posts')
  
    #   expect(page).to have_content('Post#1')
    #   expect(page).to have_content('Post#2')
    #   expect(page).to have_content('Post 1 Text')
    #   expect(page).to have_content('Post 2 Text')
  
    #   expect(page).to have_content('Comments')
    #   expect(page).to have_content('Likes')
  
    #   expect(page).to have_link('See All Posts', href: user_posts_path(@user))
    # end
  
    # scenario 'Handle no recent posts available' do
    #   # Assuming @recent_posts is empty for the user
    #   @user.recent_posts.destroy_all # Ensure no recent posts
  
    #   visit user_path(@user)
  
    #   # Check if appropriate message is displayed when no recent posts are available
    #   expect(page).to have_content('No recent posts available.')
    #   expect(page).to have_link('Create New Post', href: new_user_post_path(@user))
    # end
  end