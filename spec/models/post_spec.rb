require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'John') }
  let(:post) { Post.new(title: 'Sample Post', comments_counter: 5, likes_counter: 10, author: user) }

  it 'is valid with valid attributes' do
    expect(post).to be_valid
  end

  it 'is not valid without a title' do
    post.title = nil
    expect(post).not_to be_valid
  end

  it 'is not valid with a blank title' do
    post.title = ''
    expect(post).not_to be_valid
  end

  it 'is not valid if title exceeds 250 characters' do
    post.title = 'A' * 251
    expect(post).not_to be_valid
  end

  it 'is valid with a positive integer comments_counter' do
    post.comments_counter = 0
    expect(post).to be_valid
  end

  it 'is not valid with a negative comments_counter' do
    post.comments_counter = -1
    expect(post).not_to be_valid
  end

  it 'is not valid with a non-integer comments_counter' do
    post.comments_counter = 3.5
    expect(post).not_to be_valid
  end

  it 'is not valid with a string comments_counter' do
    post.comments_counter = 'abc'
    expect(post).not_to be_valid
  end

  it 'is valid with a positive integer likes_counter' do
    post.likes_counter = 0
    expect(post).to be_valid
  end

  it 'is not valid with a negative likes_counter' do
    post.likes_counter = -1
    expect(post).not_to be_valid
  end

  it 'is not valid with a non-integer likes_counter' do
    post.likes_counter = 3.5
    expect(post).not_to be_valid
  end

  it 'is not valid with a string likes_counter' do
    post.likes_counter = 'abc'
    expect(post).not_to be_valid
  end
end
