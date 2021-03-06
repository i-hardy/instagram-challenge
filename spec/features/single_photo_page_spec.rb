RSpec.feature "Photo pages" do
  before do
    sign_up
    upload
    visit "/"
    click_first_photo
  end

  it "shows a single photo" do
    expect(page).to have_content "@dangermouse"
    expect(page).to have_content "Emily plays chess"
  end

  it "links to the user's profile" do
    click_link "@dangermouse"
    expect(page.current_path == "/profiles/dangermouse").to eq true
  end

  it "allows users to comment on photos" do
    fill_in "comment_text", with: "Great photo!"
    click_button "..."
    expect(page).to have_content "@dangermouse: Great photo!"
  end

  it "links to the profiles of commenters" do
    fill_in "comment_text", with: "Great photo!"
    click_button "..."
    click_link "@dangermouse:"
    expect(page).to have_current_path "/profiles/dangermouse"
  end

  it "allows users to like photos" do
    within ".photo-likes" do
      find('input[name="commit"]').click
    end
    expect(page).to have_content "1 like"
  end

  it "does not allow users to like a photo more than once" do
    within ".photo-likes" do
      find('input[name="commit"]').click
    end
    expect(page).to have_no_content "2 likes"
    expect(page).to have_content "1 like"
  end

  it "links to individual tag pages" do
    click_link "#catsofynstagram"
    expect(current_path).to eq "/tags/catsofynstagram" 
  end
end
