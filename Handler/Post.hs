module Handler.Post where

import Import

getPostR :: EntryId -> Handler Html
getPostR entryId = do
  post <- runDB $ get404 entryId
  defaultLayout $(widgetFile "/posts/details")
