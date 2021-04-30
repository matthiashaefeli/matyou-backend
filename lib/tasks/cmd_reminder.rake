# frozen_string_literal: true

# Usage - Run:
# 1. dry_run: bundle exec rake cmd_reminder
# 2. live_run: bundle exec rake cmd_reminder DRY_RUN='false'

task cmd_reminder: :environment do
  Rails.logger = Logger.new(STDOUT)

  @cmds = Career.where('extract(month from created_at) = ?', Time.now.month)
                .where('extract(day from created_at) = ?', Time.now.day)

  ReminderMailer.with(cmds: @cmds).reminder_mail.deliver_later
end