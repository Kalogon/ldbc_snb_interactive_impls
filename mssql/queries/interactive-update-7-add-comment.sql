INSERT INTO Message (
    creationDate
  , MessageId
  , language
  , content
  , imageFile
  , locationIP
  , browserUsed
  , length
  , CreatorPersonId
  , ContainerForumId
  , LocationCountryId
  , ParentMessageId
)
VALUES
(
    :creationDate
  , :commentId
  , NULL
  , :content
  , NULL
  , :locationIP
  , :browserUsed
  , :length
  , :authorPersonId -- CreatorPersonId
  , NULL
  , :countryId -- LocationCountryId
  , :replyToCommentId + :replyToPostId
);
