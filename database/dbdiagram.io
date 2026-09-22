Table users {
  id uuid [primary key]
  email varchar
  username varchar
  bio text
  posts_count integer [not null, default: 0]
  followers_count integer [not null, default: 0]
  following_count integer [not null, default: 0]
  created_at timestamp
}

Table subscriptions {
  follower_id uuid [not null, ref: > users.id]
  following_id uuid [not null, ref: > users.id]
  created_at timestamp
  indexes {
    (follower_id, following_id) [unique]
    following_id
  }
}

Table posts {
  id uuid [primary key]
  user_id uuid [not null, ref: > users.id]
  description text [note: 'Content of the post']
  comments_count integer [not null, default: 0]
  likes_count integer [not null, default: 0]
  place_id uuid [not null,ref: > places.id]
  created_at timestamp
  updated_at timestamp

  indexes {
    (user_id, created_at)
    (place_id, created_at)
  }
}

Table photos {
  id uuid [primary key]
  post_id uuid [not null, ref: > posts.id]
  url varchar [not null]
  position smallint [not null, default: 0]
  indexes {
    post_id
  }
}

Table places {
  id uuid [primary key]
  name varchar [not null]
  region varchar
  radius integer [not null]
  location geography(Point, 4326) [not null]
  posts_count integer [not null, default: 0]
  indexes {
    location [type: gist]
  }
}

Table comments {
  id uuid [primary key]
  post_id uuid [not null, ref: > posts.id]
  user_id uuid [not null, ref: > users.id]
  text text
  created_at timestamp
  updated_at timestamp
  indexes {
    (post_id, created_at)
  }
}

Table likes {
  id uuid [primary key]
  user_id uuid [not null, ref: > users.id]
  post_id uuid [not null, ref: > posts.id]
  created_at timestamp
  indexes {
    (user_id, post_id) [unique]
    post_id
  }
}