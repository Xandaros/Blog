{-# LANGUAGE OverloadedStrings #-}
module Handler.PostNew where

import Yesod.Form.Bootstrap3

import Import

getPostNewR :: Handler Html
getPostNewR = do
  (entryFormWidget, entryFormEnctype) <- generateFormPost entryForm
  defaultLayout $ do
    setTitle "New Post"
    $(widgetFile "posts/new")

postPostNewR :: Handler Html
postPostNewR = do
  ((result, entryFormWidget), entryFormEnctype) <- runFormPost entryForm
  case result of
    FormSuccess post -> do
      _ <- runDB $ insert post
      redirect HomeR
    _ -> defaultLayout $(widgetFile "posts/new")

entryForm :: Form Entry
entryForm = renderDivs $ Entry <$> areq textField      (bfs ("Title"   :: Text)) Nothing
                               <*> areq textareaField  (bfs ("Content" :: Text)) Nothing
                               <*> pure Nothing
