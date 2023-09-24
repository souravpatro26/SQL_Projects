use ig_clone
/*Question-1
A) Marketing: The marketing team wants to launch some campaigns, and they need your help with the following

Rewarding Most Loyal Users: People who have been using the platform for the longest time.
Your Task: Find the 5 oldest users of the Instagram from the database provided*/;

select username,created_at 
from users
order by created_at
limit 5;

/*Question-2
Remind Inactive Users to Start Posting: By sending them promotional emails to post their 1st photo.
Your Task: Find the users who have never posted a single photo on Instagram*/;

select username from users u
left join photos p
on u.id=p.user_id
where user_id is null

/*Question-3
Declaring Contest Winner: The team started a contest and the user who gets the most likes on a single photo will win the contest now they wish to declare the winner.
Your Task: Identify the winner of the contest and provide their details to the team*/;

SELECT
    users.id AS user_id,
    username,
	photos.id AS photo_id,
    photos.image_url,
    COUNT(*) AS total_likes_count
FROM photos
    JOIN likes
        ON photos.id = likes.photo_id
    JOIN users
        ON users.id = photos.user_id
    GROUP BY photos.id
    ORDER BY total_likes_count DESC
    LIMIT 1;
    
/*Question-4
Hashtag Researching: A partner brand wants to know, which hashtags to use in the post to reach the most people on the platform.
Your Task: Identify and suggest the top 5 most commonly used hashtags on the platform*/;

SELECT
    tags.id AS tag_id,
    tags.tag_name,
    COUNT(*) as total_tags_count
FROM tags
    JOIN photo_tags
        ON tags.id = photo_tags.tag_id
    GROUP BY tags.id
    ORDER BY total_tags_count DESC
    LIMIT 5;
    
/*Question-5
Launch AD Campaign: The team wants to know, which day would be the best day to launch ADs.
Your Task: What day of the week do most users register on? Provide insights on when to schedule an ad campaign*/

SELECT
    dayname(created_at) AS day_of_the_week,
    COUNT(username) AS total_count
FROM users
    GROUP by day_of_the_week
    ORDER by total_count DESC;
    
/**Question-6
Investor Metrics: Our investors want to know if Instagram is performing well and is not becoming redundant like Facebook, they want to assess the app on the following grounds
User Engagement: Are users still as active and post on Instagram or they are making fewer posts
Your Task: Provide how many times does average user posts on Instagram. Also, provide the total number of photos on Instagram/total number of users*/;

select 
      u.id as user_id,
      count(p.id) as photo_id
 from users u
 left join 
 photos p on u.id=p.user_id
 group by u.id;
SELECT
    ROUND(
        ( SELECT COUNT(*) FROM photos ) / ( SELECT COUNT(*) FROM users ),
        2
    ) AS avg_user_post;

/**Question-7
Bots & Fake Accounts: The investors want to know if the platform is crowded with fake and dummy accounts
Your Task: Provide data on users (bots) who have liked every single photo on the site (since any normal user would not be able to do this).*/;
SELECT
    users.id AS user_id,
    users.username,
    COUNT(*) AS total_user_likes
FROM users
    JOIN likes
        ON users.id = likes.user_id
    GROUP BY users.id
    HAVING total_user_likes = (
        SELECT COUNT(*) FROM photos
    );