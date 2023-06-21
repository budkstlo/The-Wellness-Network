#!/usr/bin/perl 
#The Wellness Network 

use strict;
use warnings;

#imports modules 
use DBI; 
use CGI; 

#global variables
my $cgi = new CGI; 

#opens database
my $dbh = DBI->connect("DBI:mysql:database=mydb","username", "password"); 

#creates user table 
$dbh->do("CREATE TABLE user (
	user_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
	email VARCHAR(50) NOT NULL UNIQUE, 
	password VARCHAR(30) NOT NULL, 
	name VARCHAR(30))");

#creates topic table
$dbh->do("CREATE TABLE topic (
	topic_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	title VARCHAR(50) NOT NULL,
	description VARCHAR(200) NOT NULL,
	category VARCHAR(20),  
	user_id INTEGER NOT NULL, 	
	FOREIGN KEY(user_id) REFERENCES user(user_id))");

#creates  post table
$dbh->do("CREATE TABLE post (
	post_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
	topic_id INTEGER NOT NULL,
	date_time VARCHAR(30) NOT NULL,
	post_text VARCHAR(460) NOT NULL,
	user_id INTEGER NOT NULL, 
	FOREIGN KEY(user_id) REFERENCES user(user_id),
	FOREIGN KEY(topic_id) REFERENCES topic(topic_id))");

#creates comment table
$dbh->do("CREATE TABLE comment (
	comment_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	post_id INTEGER NOT NULL,
	comment_text VARCHAR(460) NOT NULL,
	user_id INTEGER NOT NULL, 
	date_time VARCHAR(30) NOT NULL,
	FOREIGN KEY(user_id) REFERENCES user(user_id),
	FOREIGN KEY(post_id) REFERENCES post(post_id))"); 

#accesses user input from form
my $email = $cgi->param('email');
my $password = $cgi->param('password');
my $name = $cgi->param('name');

#subroutine to insert user data into user table 
sub insert_user {
	my ($email, $password, $name) = @_; 
	$dbh->do("INSERT INTO user (email,password,name) VALUES (?,?,?)", 
		undef, $email, $password, $name); 
}

#subroutine to insert topic data into topic table 
sub insert_topic {
	my ($title, $description, $category, $user_id) = @_; 
	$dbh->do("INSERT INTO topic (title,description,category,user_id) VALUES (?,?,?,?)", 
		undef, $title, $description, $category, $user_id); 
}

#subroutine to insert post data into post table 
sub insert_post {
	my ($topic_id, $date_time, $post_text, $user_id) = @_; 
	$dbh->do("INSERT INTO post (topic_id,date_time,post_text,user_id) VALUES (?,?,?,?)", 
		undef, $topic_id, $date_time, $post_text, $user_id); 
}

#subroutine to insert comment data into comment table 
sub insert_comment {
	my ($post_id, $comment_text, $user_id, $date_time) = @_; 
	$dbh->do("INSERT INTO comment (post_id,comment_text,user_id,date_time) 
		VALUES (?,?,?,?)", undef, $post_id, $comment_text, $user_id,$date_time); 
}

#subroutine to delete user from user table 
sub delete_user {
	my ($user_id) = @_; 
	$dbh->do("DELETE FROM user WHERE user_id = ?", undef, $user_id);
}

#subroutine to delete topic from topic table 
sub delete_topic {
	my ($topic_id) = @_; 
	$dbh->do("DELETE FROM topic WHERE topic_id = ?", undef, $topic_id);
}

#subroutine to delete post from post table 
sub delete_post {
	my ($post_id) = @_; 
	$dbh->do("DELETE FROM post WHERE post_id = ?", undef, $post_id);
}

#subroutine to delete comment from comment table 
sub delete_comment {
	my ($comment_id) = @_; 
	$dbh->do("DELETE FROM comment WHERE comment_id = ?", undef, $comment_id);
}

#subroutine to update user data in user table
sub update_user {
	my ($email, $password, $name, $user_id) = @_; 
	$dbh->do("UPDATE user SET email = ?, password = ?, name = ? WHERE user_id = ?", 
		undef, $email, $password, $name, $user_id); 
}

#subroutine to update topic data in topic table 
sub update_topic {
	my ($title, $description, $category, $user_id, $topic_id) = @_; 
	$dbh->do("UPDATE topic SET title = ?, description = ?, category = ?, user_id = ? WHERE topic_id = ?", 
		undef, $title, $description, $category, $user_id, $topic_id); 
}

#subroutine to update post data in post table 
sub update_post {
	my ($topic_id, $date_time, $post_text, $user_id, $post_id) = @_; 
	$dbh->do("UPDATE post SET topic_id = ?, date_time = ?, post_text = ?, user_id = ? WHERE post_id = ?", 
		undef, $topic_id, $date_time, $post_text, $user_id, $post_id);
}

#subroutine to update comment data in comment table 
sub update_comment {
	my ($post_id, $comment_text, $user_id, $date_time, $comment_id) = @_; 
	$dbh->do("UPDATE comment SET post_id = ?, comment_text = ?, user_id = ?, date_time = ? WHERE comment_id = ?", 
		undef, $post_id, $comment_text, $user_id, $date_time, $comment_id); 
}

#subroutine to retrieve user data from user table
sub retrieve_user {
	my ($user_id) = @_; 
	my $data = $dbh->selectrow_arrayref("SELECT * FROM user WHERE user_id = ?", undef, $user_id); 
	return $data; 
}

#subroutine to retrieve topic data from topic table
sub retrieve_topic {
	my ($topic_id) = @_; 
	my $data = $dbh->selectrow_arrayref("SELECT * FROM topic WHERE topic_id = ?", undef, $topic_id); 
	return $data; 	
}

#subroutine to retrieve post data from post table
sub retrieve_post {
	my ($post_id) = @_; 
	my $data = $dbh->selectrow_arrayref("SELECT * FROM post WHERE post_id = ?", undef, $post_id); 
	return $data; 
}

#subroutine to retrieve comment data from comment table
sub retrieve_comment {
	my ($comment_id) = @_; 
	my $data = $dbh->selectrow_arrayref("SELECT * FROM comment WHERE comment_id = ?", undef, $comment_id); 
	return $data; 
}

#subroutine to display user data in html page
sub display_user_html {
	my ($data) = @_;
	my $html = 
		"<b>User ID:</b> $data->[0] <br>
		<b>Email:</b> $data->[1] <br>
		<b>Password:</b> $data->[2] <br>
		<b>Name:</b> $data->[3]"; 
	return $html; 	
}

#subroutine to display topic data in html page
sub display_topic_html {
	my ($data) = @_;
	my $html = 
		"<b>Topic ID:</b> $data->[0] <br>
		<b>Title:</b> $data->[1] <br>
		<b>Description:</b> $data->[2] <br>
		<b>Category:</b> $data->[3] <br>
		<b>User ID:</b> $data->[4]"; 
	return $html; 	
}

#subroutine to display post data in html page
sub display_post_html {
	my ($data) = @_;
	my $html = 
		"<b>Post ID:</b> $data->[0] <br>
		<b>Topic ID:</b> $data->[1] <br>
		<b>Date/Time:</b> $data->[2] <br>
		<b>Post Text:</b> $data->[3] <br>
		<b>User ID:</b> $data->[4]"; 
	return $html; 	
}

#subroutine to display comment data in html page
sub display_comment_html {
	my ($data) = @_;
	my $html = 
		"<b>Comment ID:</b> $data->[0] <br>
		<b>Post ID:</b> $data->[1] <br>
		<b>Comment Text:</b> $data->[2] <br>
		<b>User ID:</b> $data->[3] <br>
		<b>Date/Time:</b> $data->[4]"; 
	return $html; 	
}

#cgi page code
print $cgi->header(-type=>'text/html', -charset=>'utf-8');

#html code 
print <<HTML;
<html>
<head>
<title>The Wellness Network</title>
</head>
<body>
<h1>Welcome to The Wellness Network</h1>

<form>
    Email: <input type = "text" name = "email"><br>
    Password: <input type = "password" name = "password"><br>
    Name: <input type = "text" name = "name"><br>
    <input type = "submit" value = "Submit">
</form>

HTML

#inserts user data into user table
insert_user($email, $password, $name);

#selects data from user table 
my $user_data = retrieve_user(1);

#displays user data in html page 
my $user_html = display_user_html($user_data);
print $user_html; 

print <<HTML;

</body>
</html>
HTML

#disconnects from database 
$dbh->disconnect();