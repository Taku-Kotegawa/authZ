-- ユーザー情報
CREATE TABLE t_users (
    username VARCHAR(50) NOT NULL PRIMARY KEY,
    password VARCHAR(500) NOT NULL,
    enabled BOOLEAN NOT NULL
);

-- ユーザー権限
CREATE TABLE t_authorities (
    username VARCHAR(50) NOT NULL,
    authority VARCHAR(50) NOT NULL,
    CONSTRAINT fk_authorities_users FOREIGN KEY(username) REFERENCES t_users(username),
    CONSTRAINT username_authority_unique UNIQUE (username, authority)
);

-- Spring Authorization Server: クライアント情報
CREATE TABLE oauth2_registered_client (
    id varchar(100) NOT NULL,
    client_id varchar(100) NOT NULL,
    client_id_issued_at timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
    client_secret varchar(200) DEFAULT NULL,
    client_secret_expires_at timestamp DEFAULT NULL,
    client_name varchar(200) NOT NULL,
    client_authentication_methods varchar(1000) NOT NULL,
    authorization_grant_types varchar(1000) NOT NULL,
    redirect_uris varchar(1000) DEFAULT NULL,
    post_logout_redirect_uris varchar(1000) DEFAULT NULL,
    scopes varchar(1000) NOT NULL,
    client_settings varchar(2000) NOT NULL,
    token_settings varchar(2000) NOT NULL,
    PRIMARY KEY (id)
);

-- Spring Authorization Server: 認可同意情報
CREATE TABLE oauth2_authorization_consent (
    registered_client_id varchar(100) NOT NULL,
    principal_name varchar(200) NOT NULL,
    authorities varchar(1000) NOT NULL,
    PRIMARY KEY (registered_client_id, principal_name)
);

-- Spring Authorization Server: 認可状態情報
CREATE TABLE oauth2_authorization (
    id varchar(100) NOT NULL,
    registered_client_id varchar(100) NOT NULL,
    principal_name varchar(200) NOT NULL,
    authorization_grant_type varchar(100) NOT NULL,
    authorized_scopes varchar(1000) DEFAULT NULL,
    attributes TEXT DEFAULT NULL,
    state varchar(500) DEFAULT NULL,
    authorization_code_value TEXT DEFAULT NULL,
    authorization_code_issued_at timestamp DEFAULT NULL,
    authorization_code_expires_at timestamp DEFAULT NULL,
    authorization_code_metadata TEXT DEFAULT NULL,
    access_token_value TEXT DEFAULT NULL,
    access_token_issued_at timestamp DEFAULT NULL,
    access_token_expires_at timestamp DEFAULT NULL,
    access_token_metadata TEXT DEFAULT NULL,
    access_token_type varchar(100) DEFAULT NULL,
    access_token_scopes varchar(1000) DEFAULT NULL,
    oidc_id_token_value TEXT DEFAULT NULL,
    oidc_id_token_issued_at timestamp DEFAULT NULL,
    oidc_id_token_expires_at timestamp DEFAULT NULL,
    oidc_id_token_metadata TEXT DEFAULT NULL,
    refresh_token_value TEXT DEFAULT NULL,
    refresh_token_issued_at timestamp DEFAULT NULL,
    refresh_token_expires_at timestamp DEFAULT NULL,
    refresh_token_metadata TEXT DEFAULT NULL,
    user_code_value TEXT DEFAULT NULL,
    user_code_issued_at timestamp DEFAULT NULL,
    user_code_expires_at timestamp DEFAULT NULL,
    user_code_metadata TEXT DEFAULT NULL,
    device_code_value TEXT DEFAULT NULL,
    device_code_issued_at timestamp DEFAULT NULL,
    device_code_expires_at timestamp DEFAULT NULL,
    device_code_metadata TEXT DEFAULT NULL,
    PRIMARY KEY (id)
);


-- Spring Session: セッション情報
CREATE TABLE t_spring_session (
    PRIMARY_ID CHAR(36) NOT NULL,
    SESSION_ID CHAR(36) NOT NULL,
    CREATION_TIME BIGINT NOT NULL,
    LAST_ACCESS_TIME BIGINT NOT NULL,
    MAX_INACTIVE_INTERVAL INT NOT NULL,
    EXPIRY_TIME BIGINT NOT NULL,
    PRINCIPAL_NAME VARCHAR(100),
    CONSTRAINT T_SPRING_SESSION_PK PRIMARY KEY (PRIMARY_ID)
);

CREATE UNIQUE INDEX T_SPRING_SESSION_IX1 ON t_spring_session (SESSION_ID);
CREATE INDEX T_SPRING_SESSION_IX2 ON t_spring_session (EXPIRY_TIME);
CREATE INDEX T_SPRING_SESSION_IX3 ON t_spring_session (PRINCIPAL_NAME);

-- Spring Session: セッション属性
CREATE TABLE t_spring_session_attributes (
    SESSION_PRIMARY_ID CHAR(36) NOT NULL,
    ATTRIBUTE_NAME VARCHAR(200) NOT NULL,
    ATTRIBUTE_BYTES BYTEA NOT NULL,
    CONSTRAINT T_SPRING_SESSION_ATTRIBUTES_PK PRIMARY KEY (SESSION_PRIMARY_ID, ATTRIBUTE_NAME),
    CONSTRAINT T_SPRING_SESSION_ATTRIBUTES_FK FOREIGN KEY (SESSION_PRIMARY_ID) REFERENCES t_spring_session(PRIMARY_ID) ON DELETE CASCADE
);

-- Column Comments

COMMENT ON TABLE t_users IS 'ユーザー情報';
COMMENT ON COLUMN t_users.username IS 'ユーザー名';
COMMENT ON COLUMN t_users.password IS 'パスワード (BCryptハッシュ)';
COMMENT ON COLUMN t_users.enabled IS '有効フラグ';

COMMENT ON TABLE t_authorities IS 'ユーザー権限';
COMMENT ON COLUMN t_authorities.username IS 'ユーザー名';
COMMENT ON COLUMN t_authorities.authority IS '権限名 (ロール)';

COMMENT ON TABLE oauth2_registered_client IS '登録済みクライアント情報';
COMMENT ON COLUMN oauth2_registered_client.id IS 'クライアント内部ID';
COMMENT ON COLUMN oauth2_registered_client.client_id IS 'クライアントID';
COMMENT ON COLUMN oauth2_registered_client.client_id_issued_at IS 'クライアントID発行日時';
COMMENT ON COLUMN oauth2_registered_client.client_secret IS 'クライアントシークレット (BCryptハッシュ)';
COMMENT ON COLUMN oauth2_registered_client.client_secret_expires_at IS 'クライアントシークレット有効期限';
COMMENT ON COLUMN oauth2_registered_client.client_name IS 'クライアント名';
COMMENT ON COLUMN oauth2_registered_client.client_authentication_methods IS 'クライアント認証方式';
COMMENT ON COLUMN oauth2_registered_client.authorization_grant_types IS '認可グラントタイプ';
COMMENT ON COLUMN oauth2_registered_client.redirect_uris IS 'リダイレクトURI群';
COMMENT ON COLUMN oauth2_registered_client.post_logout_redirect_uris IS 'ログアウト後のリダイレクトURI群';
COMMENT ON COLUMN oauth2_registered_client.scopes IS '許可スコープ群';
COMMENT ON COLUMN oauth2_registered_client.client_settings IS 'クライアント設定 (JSON形式)';
COMMENT ON COLUMN oauth2_registered_client.token_settings IS 'トークン設定 (JSON形式)';

COMMENT ON TABLE oauth2_authorization IS '認可状態情報';
COMMENT ON COLUMN oauth2_authorization.id IS '認可状態ID';
COMMENT ON COLUMN oauth2_authorization.registered_client_id IS '登録済みクライアントID';
COMMENT ON COLUMN oauth2_authorization.principal_name IS 'プリンシパル名 (ユーザー名)';
COMMENT ON COLUMN oauth2_authorization.authorization_grant_type IS '認可グラントタイプ';
COMMENT ON COLUMN oauth2_authorization.authorized_scopes IS '認可済みスコープ群';
COMMENT ON COLUMN oauth2_authorization.attributes IS '属性情報 (JSON形式)';
COMMENT ON COLUMN oauth2_authorization.state IS '状態 (CSRFトークンなど)';
COMMENT ON COLUMN oauth2_authorization.authorization_code_value IS '認可コード値';
COMMENT ON COLUMN oauth2_authorization.authorization_code_issued_at IS '認可コード発行日時';
COMMENT ON COLUMN oauth2_authorization.authorization_code_expires_at IS '認可コード有効期限';
COMMENT ON COLUMN oauth2_authorization.authorization_code_metadata IS '認可コードメタデータ (JSON形式)';
COMMENT ON COLUMN oauth2_authorization.access_token_value IS 'アクセストークン値';
COMMENT ON COLUMN oauth2_authorization.access_token_issued_at IS 'アクセストークン発行日時';
COMMENT ON COLUMN oauth2_authorization.access_token_expires_at IS 'アクセストークン有効期限';
COMMENT ON COLUMN oauth2_authorization.access_token_metadata IS 'アクセストークンメタデータ (JSON形式)';
COMMENT ON COLUMN oauth2_authorization.access_token_type IS 'アクセストークンタイプ (例: Bearer)';
COMMENT ON COLUMN oauth2_authorization.access_token_scopes IS 'アクセストークンのスコープ群';
COMMENT ON COLUMN oauth2_authorization.oidc_id_token_value IS 'OIDC IDトークン値';
COMMENT ON COLUMN oauth2_authorization.oidc_id_token_issued_at IS 'OIDC IDトークン発行日時';
COMMENT ON COLUMN oauth2_authorization.oidc_id_token_expires_at IS 'OIDC IDトークン有効期限';
COMMENT ON COLUMN oauth2_authorization.oidc_id_token_metadata IS 'OIDC IDトークンメタデータ (JSON形式)';
COMMENT ON COLUMN oauth2_authorization.refresh_token_value IS 'リフレッシュトークン値';
COMMENT ON COLUMN oauth2_authorization.refresh_token_issued_at IS 'リフレッシュトークン発行日時';
COMMENT ON COLUMN oauth2_authorization.refresh_token_expires_at IS 'リフレッシュトークン有効期限';
COMMENT ON COLUMN oauth2_authorization.refresh_token_metadata IS 'リフレッシュトークンメタデータ (JSON形式)';
COMMENT ON COLUMN oauth2_authorization.user_code_value IS 'ユーザーコード値 (デバイスコードフロー用)';
COMMENT ON COLUMN oauth2_authorization.user_code_issued_at IS 'ユーザーコード発行日時';
COMMENT ON COLUMN oauth2_authorization.user_code_expires_at IS 'ユーザーコード有効期限';
COMMENT ON COLUMN oauth2_authorization.user_code_metadata IS 'ユーザーコードメタデータ';
COMMENT ON COLUMN oauth2_authorization.device_code_value IS 'デバイスコード値 (デバイスコードフロー用)';
COMMENT ON COLUMN oauth2_authorization.device_code_issued_at IS 'デバイスコード発行日時';
COMMENT ON COLUMN oauth2_authorization.device_code_expires_at IS 'デバイスコード有効期限';
COMMENT ON COLUMN oauth2_authorization.device_code_metadata IS 'デバイスコードメタデータ';

COMMENT ON TABLE oauth2_authorization_consent IS '認可同意情報';
COMMENT ON COLUMN oauth2_authorization_consent.registered_client_id IS '登録済みクライアントID';
COMMENT ON COLUMN oauth2_authorization_consent.principal_name IS 'プリンシパル名 (ユーザー名)';
COMMENT ON COLUMN oauth2_authorization_consent.authorities IS '認可済み権限群 (スコープ)';

COMMENT ON TABLE t_spring_session IS 'HTTPセッション情報';
COMMENT ON COLUMN t_spring_session.PRIMARY_ID IS 'プライマリーID';
COMMENT ON COLUMN t_spring_session.SESSION_ID IS 'セッションID';
COMMENT ON COLUMN t_spring_session.CREATION_TIME IS '作成日時';
COMMENT ON COLUMN t_spring_session.LAST_ACCESS_TIME IS '最終アクセス日時';
COMMENT ON COLUMN t_spring_session.MAX_INACTIVE_INTERVAL IS '最大非アクティブ期間 (秒)';
COMMENT ON COLUMN t_spring_session.EXPIRY_TIME IS '有効期限';
COMMENT ON COLUMN t_spring_session.PRINCIPAL_NAME IS 'プリンシパル名';

COMMENT ON TABLE t_spring_session_attributes IS 'HTTPセッション属性';
COMMENT ON COLUMN t_spring_session_attributes.SESSION_PRIMARY_ID IS 'セッションプライマリーID';
COMMENT ON COLUMN t_spring_session_attributes.ATTRIBUTE_NAME IS '属性名';
COMMENT ON COLUMN t_spring_session_attributes.ATTRIBUTE_BYTES IS '属性値 (バイト配列)';
