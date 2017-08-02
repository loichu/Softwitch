export default  class Button extends React.Component {
    openLink () {
        let target = this.props.openInNewTab ? "_blank" : "_self",
            href   = this.props.href;

        window.open(href, target);
    }
    render ()
    {
        // Get props in variables
        let href      = this.props.href,
            size      = this.props.size,
            color     = this.props.color,
            className = this.props.className,
            id        = this.props.id,
            text      = this.props.text,
            disabled  = !href;

        // Make actual classes
        let classes = `btn btn-${color} ${size ? "btn-" + size : ""} ${className}`;

        return (
            <button
                id={id}
                className={classes}
                onClick={(href ? this.openLink.bind(this) :
                    (this.props.onClick ? this.props.onClick :
                        ""))}
                disabled={disabled}
            >{text}</button>
        );
    }
}

//export default Button