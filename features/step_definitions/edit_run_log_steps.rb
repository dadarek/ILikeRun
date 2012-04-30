When /I click on delete next to the first run log/ do
  id = @user.run_logs.first.id
  find("input[data-delete-log='#{id}']").click
end

When /I click on edit next to the first run log/ do
  id = @user.run_logs.first.id
  find("a[href='#{edit_run_log_path(id)}']").click
end


