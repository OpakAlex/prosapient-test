defmodule ElixirTest do
  defmodule Wrap do
    def list(a, b) when is_list(a) and is_list(b)  do
      Enum.reduce(a, [], fn(element, acc) ->
       acc ++ wrap_list(b, element)
      end)
    end

    def list(a,b) do
      IO.inspect("You must pass 2 lists!")
    end

    def wrap_list(list, first_element) do
      Enum.reduce(list, [], fn(element, acc) ->
        acc ++ [[a: first_element, b: element]]
      end)
    end
  end

  defmodule EctoTask do
    """
    Structure:

      CREATE TABLE users (
      id integer PRIMARY KEY
      );

      CREATE TABLE posts (
      user_id integer,
      kind varchar(40) -- only 'article', 'promotion', 'link', 'image',
      );

      INSERT INTO users(id) VALUES (1);
      INSERT INTO users(id) VALUES (2);

      INSERT INTO posts(user_id, kind) VALUES (1, 'article');
      INSERT INTO posts(user_id, kind) VALUES (1, 'article');
      INSERT INTO posts(user_id, kind) VALUES (1, 'promotion');
      INSERT INTO posts(user_id, kind) VALUES (1, 'image');
      INSERT INTO posts(user_id, kind) VALUES (1, 'image');
      INSERT INTO posts(user_id, kind) VALUES (1, 'link');

      INSERT INTO posts(user_id, kind) VALUES (2, 'link');
      INSERT INTO posts(user_id, kind) VALUES (2, 'link');


      SQL:

        SELECT u.id,
               COUNT (*) FILTER (WHERE kind = 'article') AS article_count,
               COUNT (*) FILTER (WHERE kind = 'promotion') AS promotion_count,
               COUNT (*) FILTER (WHERE kind = 'link') AS link_count,
               COUNT (*) FILTER (WHERE kind = 'image') AS image_count
          FROM users AS u
          LEFT JOIN posts AS p
            ON p.user_id = u.id
         GROUP BY u.id;

       Ecto part:

         import Ecto.Query
         from(
           user in User,
           left_join: post in Post, on: post.user_id == user.id,
           group_by: user.id,
           select: {
           %{
             user_id: user.id
             article_count: fragment("COUNT (*) FILTER (WHERE kind = 'article') AS article_count"),
             promotion_count: fragment("COUNT (*) FILTER (WHERE kind = 'promotion') AS promotion_count"),
             link_count: fragment("COUNT (*) FILTER (WHERE kind = 'link') AS link_count"),
             image_count: fragment("COUNT (*) FILTER (WHERE kind = 'image') AS image_count"),
           }
           }
         )

         Din't run it in real case ;)
    """
  end
end
