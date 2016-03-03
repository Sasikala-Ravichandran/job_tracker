module ApplicationHelper
  def transform_url(url_link, path)
    replace_url = "https://www.dropbox.com/s"
    final_link = url_link.gsub(/^.*?(?>view)/im, replace_url).sub!(path, "")
  end
end
