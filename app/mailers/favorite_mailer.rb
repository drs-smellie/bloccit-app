class FavoriteMailer < ActionMailer::Base
  default from: "melanie.keatley@gmail.com"

  def new_comment(user, post, comment)
    @user = user
    @post = post
    @comment = comment

    # New Headers
    headers["Message-ID"] = "<comments/#{@comment.id}@drs-smellie-bloccit.herokuapp.com>"
    headers["In-Reply-To"] = "<post/#{@post.id}@ydrs-smellie-bloccit.herokuapp.com>"
    headers["References"] = "<post/#{@post.id}@drs-smellie-bloccit.herokuapp.com>"

    mail(to: user.email, subject: "New comment on #{post.title}")
  end
end