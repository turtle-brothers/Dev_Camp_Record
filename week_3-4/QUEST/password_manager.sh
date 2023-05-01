#!/bin/bash

echo 'パスワードマネージャーへようこそ！'
echo '次の選択肢から入力してください(Add Password/Get Password/Exit): '

PASSWORD_FILE="password.txt"
extension=".gpg"
ENCRYPTED_PASSWORD_FILE+="${PASSWORD_FILE}${extension}"
gpg_pass=$(cat gpg_passfrase)

while :
do
  read selected_option
  case "$selected_option" in
    "Add Password")
      read -p 'サービス名を入力してください： ' service_name
      read -p 'ユーザー名を入力してください： ' user_name
      read -p 'パスワードを入力してください： ' password
      echo "$gpg_pass" | gpg --passphrase="$gpg_pass" --batch --yes --quiet -o "$PASSWORD_FILE" -d "$ENCRYPTED_PASSWORD_FILE"
      echo $service_name:$user_name:$password >> "$PASSWORD_FILE"
      echo 'パスワードの追加に成功しました。'
      echo "$gpg_pass" | gpg --passphrase="$gpg_pass" --batch --yes -c "$PASSWORD_FILE"
      rm "$PASSWORD_FILE"
      echo '次の選択肢から入力してください(Add Password/Get Password/Exit): '
      ;;
    "Get Password")
      read -p 'サービス名を入力してください： ' service_name
      echo "$gpg_pass" | gpg --passphrase="$gpg_pass" --batch --yes --quiet -o "$PASSWORD_FILE" -d "$ENCRYPTED_PASSWORD_FILE"
      if grep -q "^${service_name}" "$PASSWORD_FILE"; then
          array=($(tac "$PASSWORD_FILE" | grep -m 1 "^${service_name}"))
          array_split=(${ array//:/ })
          echo "service_name:${array_split[0]}"
          echo "user_name:${array_split[1]}"
          echo "password:${array_split[2]}"
      else
          echo "そのサービスは登録されていません。"
      fi
      echo "$gpg_pass" | gpg --passphrase="$gpg_pass" --batch --yes -c "$PASSWORD_FILE"
      rm "$PASSWORD_FILE"
      echo '次の選択肢から入力してください(Add Password/Get Password/Exit): '
      ;;
    "Exit")
      echo 'Thank you!'
      break
      ;;
    *)
      echo '入力が間違っています。Add Password/Get Password/Exit から入力してください。'
  esac
done
