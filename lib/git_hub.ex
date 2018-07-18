defmodule GitHub do
  use HTTPotion.Base

  def starts(repo) do
    %HTTPotion.Response{body: body, status_code: status} = get("repos/" <> repo)
    if status < 400 do
      {:ok, body["stargazers_count"]}
    else
      {:error, "repo is private or missing"}
    end
  end

  def process_url(url) do
    "https://api.github.com/" <> url
  end

  def process_request_headers(headers) do
    Dict.put headers, :"User-Agent", "github-potion"
  end

  def process_response_body(body) do
    body |> Poison.decode!
  end
end
